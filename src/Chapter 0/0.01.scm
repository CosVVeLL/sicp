//the difference of the angles
const diff = (a, b) => {
	let lt = 0;
	let gt = 0;

	if (a < b) {
		lt = a; gt = b;
	} else if (a > b) {
		lt = b; gt = a;
	} else {
		return 0;
	}
	if (lt + 180 < gt) {
		return (360 + lt) - gt;
	}
	return gt - lt;
};
