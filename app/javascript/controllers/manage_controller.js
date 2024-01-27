import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["searchbar", "btn"];

    connect() {
        this.btnTarget.hidden = true;
    }

    runSearch() {
        this.btnTarget.click();
    }
}
