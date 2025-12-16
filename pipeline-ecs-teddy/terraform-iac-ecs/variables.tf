
variable "environment" {
	description = "Nome do ambiente (ex: dev, staging, prod)"
	type        = string
}

variable "cluster_name" {
	description = "Nome do cluster ECS"
	type        = string
	default     = "ecs-teste-teddy"
}

variable "subnet_ids" {
	description = "Lista de subnets para o serviço ECS"
	type        = list(string)
}

variable "container_image" {
	description = "Imagem do container a ser utilizada"
	type        = string
}

variable "container_port" {
	description = "Porta exposta pelo container"
	type        = string
}
