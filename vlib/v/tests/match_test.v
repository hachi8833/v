enum Color {
	red
	green
	blue
}

pub fn (c Color) str() string {
	return 'tmp'
}

fn test_match_integers() {
	mut a := 3
	mut b := 0
	match a
	2 {
		println('two')
	}
	3 {
		println('three')
		b = 3
	}
	4 {
		println('four')
	}
	else {
		println('???')
	}
	assert b == 3
	assert match 2 {
		1 { 2 }
		2 { 3 }
		else { 5 }
	} == 3
	assert match 0 {
		1 { 2 }
		2 { 3 }
		else { 5 }
	} == 5
	assert match 1 {
		else { 5 }
	} == 5
	a = 0
	match 2 {
		0 {
			a = 1
		}
		1 {
			a = 2
		}
		else {
			a = 3
			println('a is $a')
		}
	}
	assert a == 3
	a = 0
	match 1 {
		0 {
			a = 1
		}
		1 {
			a = 2
			a = a + 2
			a = a + 2
		}
		else {}
	}
	assert a == 6
	a = 0
	match 1 {
		else { a = -2 }
	}
	assert a == -2
}

fn test_match_multiple() {
	assert match 9 {
		1, 2, 3 { '1-3' }
		4, 5 { '4-5' }
		6...9 { '6-9' }
		else { 'other' }
	} == '6-9'
}

fn test_match_range() {
	assert match `f` {
		`0`...`9` { 'digit' }
		`A`...`Z` { 'uppercase' }
		`a`...`z` { 'lowercase' }
		else { 'other' }
	} == 'lowercase'
}

fn test_match_enums() {
	mut b := Color.red
	match b {
		.red {
			b = .green
		}
		.green {
			b = .blue
		}
		else {
			println('b is $b.str()')
			b = .red
		}
	}
	assert b == .green
	match b {
		.red {
			b = .green
		}
		else {
			println('b is $b.str()')
			b = .blue
		}
	}
	assert b == .blue
}

type Sum = A1 | B1

struct A1 {
	pos int
}

struct B1 {
	val string
}

fn f(s Sum) string {
	match s {
		A1 { return typeof(s) }
		B1 { return '' }
	}
	return ''
}

fn test_sum_type_name() {
	a := A1{
		pos: 22
	}
	assert f(a) == 'A1'
}
