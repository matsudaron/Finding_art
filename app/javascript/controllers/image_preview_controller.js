import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];

  connect() {
    console.log("ImagePreviewController connected");
  }

  previewImage(event) {
    console.log("File input changed");
    const file = event.target.files[0];
    const reader = new FileReader();
    const preview = this.previewTarget;

    console.log("Reading file as DataURL");
    reader.onload = function() {
      console.log("FileReader onloadend");
      preview.src = reader.result;
      preview.style.display = "block";
    };

    if (file) {
      reader.readAsDataURL(file);
    }
  }
}
