---
alias: atiede8ata
path: /docs/reference/file-handling/image-api
layout: REFERENCE
description: The file management system allows you to upload, modify and delete files with the GraphQL APIs. Files will be directly available in your backend.
tags:
  - file-handling
related:
  further:
  more:
---

# Image API

The Image API provides a very thin layer on top of the File API for image transformations.

Once an image has been calculated, it is persisted at the respective URL. Calling it again will not initiate another calculation. Only images up to 25MB can be transformed, and final results up to 6MB can be downloaded.

The base URL of a supported image uploaded through the File API is:

```
https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/
```

### Resizing

* `https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/500x300`: Fit into 500px x 300px rectangle
* `https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/500x300!`: Forced resize
* `https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/500x`: Resize to 500px width maintaining aspect ratio
* `https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/x300`: Resize to 300px height maintaining aspect ratio

### Cropping

* `https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/0x0:400x400`: Crops the image taking the first 400x400 square

> Cropping starts from left-top corner

### Resizing and Cropping

`https://images.graph.cool/v1/__PROJECT_ID__/__FILE_SECRET__/0x0:400x400/250x250`: Crops the image taking the first 400x400 square and fit into 250px x 250px rectangle

> Images are cropped before being resized.

### Contributions

Contributions and improvements to the Image API are welcome! For more information, see [serverless-image-proxy](https://github.com/graphcool/serverless-image-proxy).
