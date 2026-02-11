#группа супервользователей
class users::root {
  case $facts['os']['family'] {
    'Debian': { $group='root' }
    default:  { $group='wheel' }
  }
}
