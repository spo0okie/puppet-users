#Нагло украдено с https://habrahabr.ru/post/126487/
#Впоследствии может быть модифицировано немнго. А может и нет


# Определяем класс и присваиваем значения по умолчанию, если не передано значений при объявлении класса.
class users::sudoers {
	#определяемся с пользователем:
	case $::operatingsystem  {
		'FreeBSD': {
			$filepath='/usr/local/etc/sudoers'
			$group='wheel'
		}
		'Debian', 'Ubuntu': {
			$filepath='/etc/sudoers'
			$group='sudo'
		}
		default: {
			$filepath='/etc/sudoers'
			$group='wheel'
		}
	}

	file_line {'sudoers_group':
		path	=>	$filepath,
		line	=>	"%$group	ALL=(ALL)	NOPASSWD:ALL",
		match	=>	'^%$group\s'
	}
}