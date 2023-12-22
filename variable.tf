 variable "region" {
   type = string
 }
 
 variable "identifier" {
   type = string
 }

variable "allocated_storage" {
  type = string
}
 variable "storage_type" {
   type = string
 }
 variable "engine_version" {
   type = string
 }
 
 variable "db_tags" {
   type = map(string)
 }

  variable "vpc_tags" {
   type = map(string)
 }
 
 variable "database_name" {
   type = string
 }

 variable "cluster_identifier" {
   type = string
 }
  variable "db_subnet_tags" {
   type = map(string)
 }

  variable "app_subnet_tags" {
   type = map(string)
 }

  variable "instance_class" {
   type = string
 }

 variable "username" {
   type = string
 }


variable "db_password" {
  type        = string
  sensitive   = true
}