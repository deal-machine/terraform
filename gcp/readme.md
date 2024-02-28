<div align="center">
<img width="300" src="https://user-images.githubusercontent.com/25181517/183345121-36788a6e-5462-424a-be67-af1ebeda79a2.png" />
</div>

<div align="right">
<a href="https://www.terraform.io/">terraform.io</a>
</div>

<br>


## Requirements

- Create a project on GCP
- Create a service account
  - with basic/editor role
  - create keys and credentials
- Create on google-cloud-storage a Bucket to storage .tfstate
  - deal-terraform-bucket
- Configure gcloud.tfvars with gcp config variables
  - project_id
  - region