variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "webappsCount" {
    description = "How many regions do we want the webapps to deploy to"
    default     = 1
    type        = number
}


variable "webapplocs" {
  
    description = "List of locations for web apps"
    type        = list(string)
    default     = ["uksouth", "uksouth"]
}


variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}