class users::root {
	case $::operatingsystem {
		'Debian','Ubuntu':	{ $group='root' }
		default:			{ $group='wheel' }
	}
}