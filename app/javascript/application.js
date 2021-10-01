// Entry point for the build script in your package.json
import * as bootstrap from "bootstrap"
import * as fontawesome from "@fortawesome/fontawesome-free"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
