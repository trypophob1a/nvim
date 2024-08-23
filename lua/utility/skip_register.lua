local skip_register = {}
skip_register.files = {}

function skip_register.Add(files)
  for _, file in ipairs(files) do
    skip_register.files[file] = true
  end
end

function skip_register.Contains(key)
  return skip_register.files[key] == true
end

function skip_register.Remove(key)
  skip_register.files[key] = nil
end

return skip_register
