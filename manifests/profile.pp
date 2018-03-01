define users::profile() {
	# создаём папку пользователя
	file { "/home/$title":
		ensure	=>	directory,
		owner	=>	"$title",
		group	=>	"$title",
		mode	=>	'0700',
	} ->

	# создаём папку .ssh для нашего публичного ключа
	file { "/home/$title/.ssh":
		ensure	=>	directory,
		owner	=>	"$title",
		group	=>	"$title",
		mode	=>	'0700',
	} 

	# файл настроек шелла
	file { "/home/$title/.shrc":
		ensure	=>	file,
		owner	=>	"$title",
		group	=>	"$title",
		mode	=>	'0644',
		require	=>	File["/home/$title"]
	} 
	file_line {"/home/$title/.shrc/LC_ALL":
		path	=>  "/home/$title/.shrc",
		require	=>	File["/home/$title/.shrc"],
		line	=>  'export LC_ALL=en_US.UTF-8',
		match	=>  '^export\s*LC_ALL='
	}
	file_line {"/home/$title/.shrc/LANG":
		path	=>  "/home/$title/.shrc",
		require	=>	File["/home/$title/.shrc"],
		line	=>  'export LANG=en_US.UTF-8',
		match	=>  '^export\s*LANG='
	}
	file_line {"/home/$title/.shrc/LANGUAGE":
		path	=>  "/home/$title/.shrc",
		require	=>	File["/home/$title/.shrc"],
		line	=>  'export LANGUAGE=en_US.UTF-8',
		match	=>  '^export\s*LANGUAGE='
	}
	file_line {"/home/$title/.shrc/SHELL":
		path	=>  "/home/$title/.shrc",
		require	=>	File["/home/$title/.shrc"],
		line	=>  'export SHELL=bash',
		match	=>  '^export\s*SHELL='
	}
}


