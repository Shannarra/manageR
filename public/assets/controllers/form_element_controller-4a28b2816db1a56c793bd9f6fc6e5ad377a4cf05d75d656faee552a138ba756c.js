import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "access_type", "output" ]

    connect() {
        // this.element.textContent = "Hello World!"
        console.log('Hello World form element controller .js');
        console.log(`${this.access_typeTarget.value} asd`);
        //      this.outputTarget.hidden = true;
        setAccessTypeTooltip();
    }

    setAccessTypeTooltip() {
        const value = this.access_typeTarget.value;
        let tooltip = "";

        switch(value) {
            case "admin": tooltip = "User is an administrator of the system."; break;
            case "director": tooltip = "User is the director of the current institution."; break; 
            case "teacher": tooltip = "User is a teacher in the current institution."; break; 
            case "student": tooltip = "User is a student the current institution."; break; 
            case "unassigned": tooltip = "User has no assigned role."; break;
            default: tooltip = "I have no idea what happened. Check the JS controller."; break;
        }
        
        this.outputTarget.text = tooltip;
    }
};
