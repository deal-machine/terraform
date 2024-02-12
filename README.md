<div align="center">
<img width="300" src="https://user-images.githubusercontent.com/25181517/183345121-36788a6e-5462-424a-be67-af1ebeda79a2.png" />
</div>

## Terraform  [terraform.io](https://www.terraform.io/)

> Código que gera e **provisiona** infraestrutura IaC - *Infrastructure as Code*. Cria todos os componentes da nossa infraestrutura em diversos *providers*, através de uma camada de abstração.

- **Components**: Servidor, banco de dados, máquina virtual, vpc, secutiry-group, sub-net, internet gateway, etc...
- **Idempotency**: idempotência é a caracteristica de se manter inalteravel, o resultado da operação é sempre o mesmo independente das vezes que a operação é executada.
- **Declarative**: diz o que fazer, pede apenas o resultado final.
- **State**: arquivo que garante o gerenciamento de estado, descreve tudo que aconteceu e o estado atual da infraestrutura.

<br> 

Terraform vs Ansible
> Terraform provisiona a infraestrutura, o Ansible faz a automatização de configurações.
