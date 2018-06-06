## Terraform introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Version used:
*   Terraform 0.11.2

## Google cloud authentification
Authenticating with Google Cloud services requires a JSON file which we call the account file.

This file is downloaded directly from the Google Developers Console. To make the process more straightforwarded, it is documented here:

1.  Log into the [Google Developers Console](https://console.developers.google.com/) and select a project.

2.  The API Manager view should be selected, click on "Credentials" on the left, then "Create credentials", and finally "Service account key".

3.  Select "Compute Engine default service account" in the "Service account" dropdown, and select "JSON" as the key type.

4.  Clicking "Create" will download your credentials.


Finaly set json file in the terraform provider section
```
provider "google" {
  credentials = "${file("account.json")}"
  project     = "my-gce-project-id"
  region      = "us-central1"
}
```

## Getting Started

Before terraform apply you must download provider plugin:

```
terraform init
```

Display plan before apply manifest
```
terraform plan
```

Apply manifest
```
terraform apply
```

Destroy stack
```
terraform destroy
```

## Documentation
[https://www.terraform.io/docs/providers/google/index.html](https://www.terraform.io/docs/providers/google/index.html)
