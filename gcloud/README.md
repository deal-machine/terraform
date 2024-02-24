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


## AWS Infrastructure

- VPC - Virtual Private Cloud
- Subnet
- AV - Availability Zones
- Route Table - Routing table for VPC, describe available subnets
- Internet Gateway - Allow external(public) access
- Security Group - Firewall
- Ingress - quem acessa nossos recursos
- Egress - quem nossos recursos acessam

<div align="center">
  <img width="1000" src="./assets/vpc.png" />
</div>