#Нагло украдено с https://habrahabr.ru/post/126487/
#Впоследствии может быть модифицировано немнго. А может и нет


# Определяем класс и присваиваем значения по умолчанию, если не передано значений при объявлении класса.
define users::manage($action = "create", $m_groups = $title) {
	#определяемся с пользователем:
	case $action  {
		
		create: {
			# создаем группу
			group { "$title":
				ensure	=>	present
			} ->
			
			# создаём пользователя
			user { "$title":
				ensure	=>	present,
				# добавляем в группы (группы передаются массивом)
				groups	=>	$m_groups,
				comment	=>	"$title",
				home	=>	"/home/$title",
				shell	=>	"/bin/bash",
				
				# на некоторых системах доступа по SSH не будет пока пользователь заблокирован "passwd -u -f <user>". Это можно обойти, задав пароль пользователю:
				# password => "$6$fdrc...tut_hash_moego_parolya....ovj0",
				# создаём домашнюю папку
				
				managehome => true,
			} ->
			
			# создаём папку .ssh для нашего публичного ключа
			file { "/home/$title/.ssh":
				ensure	=>	"directory",
				owner	=>	"$title",
				group	=>	"$title",
				mode	=>	700,
			} ->
			
			# размещаем ключ и назначаем соответствующие права на него
			file { "/home/$title/.ssh/authorized_keys":
				owner	=>	"$title",
				group	=>	"$title",
				mode	=>	"0400",
				content	=>	template("users/keys/$title.erb");
			}
		}
		
		delete: {
			# Логика удаления пользователя с сервера:
			#
			# В данном месте логично разместить различные скрипты по очистке системы от пользовательских файлов или передачи прав другим пользователям, а также прочие действия, связанные с удалением пользователя из системы
			# пример: 
			# find / -user $title -exec <что_то_сделать_с_файлами_пользователя> {} \;
			# find / -group test_v99 -exec chgrp root {} \;
			# 
			# Проверяем наличие домашней папки и удаляем её, если она есть (onlyif =>...)
			# exec { "rm -r /home/$title":
			#	path => ["/usr/bin", "/usr/sbin", "/bin"],
			#	onlyif => "test -d /home/$title",
			#}
			# Последним шагом удаляем пользователя
			user {"$title":
				ensure => absent,
			}
		}
	}
}