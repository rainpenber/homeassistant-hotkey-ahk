#Requires AutoHotkey v2.0

; 引入 WinHttp COM 对象
#Include <WinHttp>

class HomeAssistant {
    __New() {
        ; 从ini文件读取配置
        this.LoadConfig()
        this.http := WinHttpRequest()
    }

    LoadConfig() {
        ; 读取基础配置
        this.BASE_URL := IniRead("ha_shortcuts.ini", "Config", "BASE_URL")
        this.AUTH_TOKEN := IniRead("ha_shortcuts.ini", "Config", "AUTH_TOKEN")
        
        ; 读取所有快捷键配置
        this.LoadShortcuts()
    }

    LoadShortcuts() {
        try {
            ; 先获取所有键名按行分割
            allShortcuts := IniRead("ha_shortcuts.ini", "Shortcuts")
            shortcuts := StrSplit(allShortcuts, "`n", "`r")
            
            ; 遍历每一行
            for line in shortcuts {
                ; 分割键值对
                parts := StrSplit(line, "=")
                if (parts.Length = 2) {
                    ; 创建局部变量来保存当前值
                    thisShortcut := parts[1]
                    command := parts[2]
                    
                    ; 解析命令
                    commandParts := StrSplit(command, ",")
                    if (commandParts.Length >= 3) {
                        ; 创建局部变量来保存当前命令参数
                        thisDomain := commandParts[1]
                        thisOperation := commandParts[2]
                        thisEntity := commandParts[3]
                        thisParams := commandParts.Length > 3 ? commandParts[4] : ""
                        
                        ; 使用立即执行的函数来创建独立作用域
                        HotKey(thisShortcut, ((shortcut, domain, operation, entity_id, params) => 
                            (*) => (
                                ; ToolTip("触发快捷键: " shortcut "`n控制设备: " entity_id),
                                ; SetTimer(() => ToolTip(), -1000),
                                this.CallService(domain, operation, entity_id, params)
                            ))(thisShortcut, thisDomain, thisOperation, thisEntity, thisParams))
                    }
                }
            }
        } catch Error as err {
            MsgBox("加载快捷键配置失败：" err.Message)
        }
    }

    CallService(domain, operation, entity_id, params := "") {
        url := this.BASE_URL . "/api/services/" . domain . "/" . operation
        
        ; 处理额外参数
        if (params) {
            ; 如果有额外参数，解析并合并
            extraParams := StrSplit(entity_id, "|")
            if (extraParams.Length = 2) {
                entity_id := extraParams[1]
                postData := StrReplace(extraParams[2], "entity_id", entity_id)
            }
        } else {
            ; 基本的请求体
            postData := '{"entity_id": "' . entity_id . '"}'
        }
        
        this.http.Open("POST", url)
        this.http.SetRequestHeader("Content-Type", "application/json")
        this.http.SetRequestHeader("Authorization", this.AUTH_TOKEN)
        
        try {
            this.http.Send(postData)
            response := this.http.ResponseText
            ; MsgBox("请求成功`n响应内容：" response)
        } catch Error as err {
            MsgBox("请求失败：" err.Message)
        }
    }
}

; 创建 HomeAssistant 实例
ha := HomeAssistant()