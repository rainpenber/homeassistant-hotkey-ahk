class WinHttpRequest {
    __New() {
        this.whr := ComObject("WinHttp.WinHttpRequest.5.1")
    }

    Open(method, url) {
        this.whr.Open(method, url, true)
    }

    Send(body := "") {
        this.whr.Send(body)
        this.whr.WaitForResponse()
    }

    SetRequestHeader(header, value) {
        this.whr.SetRequestHeader(header, value)
    }

    ResponseText => this.whr.ResponseText
}