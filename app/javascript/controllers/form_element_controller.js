import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["submitbtn"];

    connect() {
        this.submitbtnTarget.hidden = true;
        console.log('asdasd');
    }

    remotesubmit() {
        throw new Error('adsasd');
        console.log('gere');
        this.submitbtnTarget.click();
    }
}
