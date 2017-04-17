---
alias: eer4wiang0
path: /docs/reference/platform/file-management
layout: REFERENCE
description: The file management system allows you to upload, modify and delete files with the GraphQL APIs. Files will be directly available in your backend.
tags:
  - platform
  - file-management
  - plain-http
  - client-apis
related:
  further:
    - eetai5meic
  more:
    - eefoovo2ah
---

# File Management

As part of our file management system you are able to

* upload files that are up to 50 MB
* rename or delete existing files

Each project contains a [file model](!alias-uhieg2shio#file-model) by default that provides the possibility to add and modify files.

## Uploading a file with plain HTTP

<!-- GITHUB_EXAMPLE('File upload with fetch', 'https://github.com/graphcool-examples/react-apollo-file-upload-example') -->

Use the file endpoint `https://api.graph.cool/file/v1/__PROJECT_ID__` to upload files by using the multipart form parameter `data` and providing the local file path as its value in a HTTP POST request.
With`curl` you could execute:

`curl -X POST 'https://api.graph.cool/file/v1/__PROJECT_ID__' -F "data=@example.png"`

The response could look something like this:

```JSON
{
  "secret": "__SECRET__",
  "name": "example.png",
  "size": <omitted>,
  "url": "https://files.graph.cool/__PROJECT_ID__/__SECRET__",
  "id": <omitted>,
  "contentType": "image/png"
}
```

After this request, the file is publicly available at its `url`. Each property in the response corresponds to a field of the [file model](!alias-uhieg2shio#file-model).

## Image API

When downloading images, you can use a separate image API to control the size of the file. To get a 600x500 image, you can use

```
https://images.graph.cool/__PROJECT_ID__/__FILE_ID__/600x500
```

For more information, see [serverless-image-proxy](https://github.com/graphcool/serverless-image-proxy).

## File Management with the Client APIs

Currently, files cannot be uploaded from the [Simple API](!alias-heshoov3ai) or the [Relay API](!alias-aizoong9ah). Read [this issue on GitHub](https://github.com/apollographql/apollo/issues/65) for more information.

## File Access

Currently, **uploading and downloading files is allowed to everyone**. **The file itself is publicly available at the url of the file node**, so everyone who knows the file secret and your project id has access the file.

**You can protect the file secrets** using the permission system as usual though, so you can make sure that only users who are supposed to find a file are able to query its secret.
