<div align="center">
<img width="300" src="https://user-images.githubusercontent.com/25181517/183345121-36788a6e-5462-424a-be67-af1ebeda79a2.png" />
</div>

<div align="right">
<a href="https://www.terraform.io/">terraform.io</a>
</div>

<br>

> Código que gera e **provisiona** infraestrutura IaC - *Infrastructure as Code*. Cria todos os componentes da nossa infraestrutura em diversos *providers*, através de uma camada de abstração.

- **Providers**: plugin que interage com diversos provedores de nuvem como AWS, Azure, Google Cloud, Docker, Kubernetes, etc.
- **Resources**: Componentes individuais que fazem parte da infraestrutura.
- **Modules**: São blocos reutilizaveis de configurações que modularizam o código, agrupamento de _resources_.
- **Variables**: Parametrizam os dados de arquivos de configurações.
- **Components**: Servidor, banco de dados, máquina virtual, vpc, secutiry-group, sub-net, internet gateway, etc...
- **Idempotency**: idempotência é a caracteristica de se manter inalteravel, o resultado da operação é sempre o mesmo independente das vezes que a operação é executada.
- **Declarative**: diz o que fazer, pede apenas o resultado final.
- **State**: arquivo que garante o gerenciamento de estado, descreve tudo que aconteceu e o estado atual da infraestrutura.
- **Output**: Saida de informações a respeito do provisionamento da infraestrutura gerada.
- **Backend**: Local onde se armazena o arquivo de gerenciamento de estado.

<br> 

Terraform vs Ansible
> Terraform provisiona a infraestrutura, o Ansible faz a automatização de configurações.

<br>

## HCL - HashiCorp Configuration Language

- initialize
  - ``terraform init``
- validate
  - ``terraform validate``
- format
  - ``terraform fmt``
- plan
  - ``terraform plan``
- execute
  - ``terraform apply``
- finish
  - ``terraform destroy``
- variables
  - direct on tf file
  - terraform.tfvars
  - ``-var`` or ``-var-file`` on apply command
- outputs
- data sources

<br>

## Requirements

- Created AWS Bucket to storage .tfstate
  - deal-terraform-bucket
- Configure aws.tfvars with aws config variables
  - access_key
  - secret_key
  - token
  - region(us-east-1)

## To init

`terraform init -var-file=aws.tfvars`

## To run 

`terraform apply -var-file=aws.tfvars --auto-approve`

## To destroy 

`terraform destroy -var-file=aws.tfvars --auto-approve`

## To connect on kubectl

`aws eks update-kubeconfig --name <nome-do-seu-cluster-EKS>`

## To formate terraform code

`terraform fmt -recursive`

<br> 

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