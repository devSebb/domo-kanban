// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import DropdownController from "./dropdown_controller"
import InviteFormController from "./invite_form_controller"

// Register controllers manually
application.register("dropdown", DropdownController)
application.register("invite-form", InviteFormController)

// Load and register other controllers
eagerLoadControllersFrom("controllers", application)
