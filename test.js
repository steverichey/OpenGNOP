var test = require('tape');

test('doesitrun', function (t) {
	t.plan(1);
	var game = OS7;
	t.notEqual(game,null);
});