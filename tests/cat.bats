@test "if cat is invoked with a nonexistent file then expect an error message" {
  run cat xfile
  [[ ${output} == "catx: xfile: No such file or directory" ]]
}
