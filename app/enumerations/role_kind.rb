class RoleKind < EnumerateIt::Base
  associate_values regular: 0, admin: 1, pastor: 2,
    blogger: 3, accountant: 4, teacher: 5, director: 6
end
