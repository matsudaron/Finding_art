import { definitionsFromContext } from "stimulus/webpack-helpers";

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

import ImagePreviewController from "./image_preview_controller";
application.register("image-preview", ImagePreviewController);
