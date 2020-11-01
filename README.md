# puppet-users
Управление пользователями

ключи вынесены из этого модуля в общее хранилище puppet:///code_files/userkeys  
чем это чревато?  
тем что надо явно объявить эту папку в файле /etc/puppetlabs/puppet/fileserver.conf
  [code_files]
      path /etc/puppetlabs/code/files
      allow *

ну и собственно сделать папку
/etc/puppetlabs/code/files/userkeys
и сложить туда открытые ключи по шаблону %username%
