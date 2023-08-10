output "multiline" {
    value = replace(var.multiline, "\\n", "\n")
}
