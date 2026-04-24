// Click-anywhere favicon toggle — preserved from the original site.
document.head = document.head || document.getElementsByTagName('head')[0];
document.getElementById('app').addEventListener('click', function () {
	var links = document.getElementsByTagName('link');
	var oldLink;
	for (var i = 0; i < links.length; i++) {
		if (links[i].id === 'dynamic-favicon') {
			oldLink = links[i];
			break;
		}
	}
	var link = document.createElement('link');
	link.id = 'dynamic-favicon';
	link.rel = 'shortcut icon';
	if (oldLink.href.toString().indexOf('assets/handWhite.ico') > 0) {
		link.href = 'assets/handRed.ico';
	} else {
		link.href = 'assets/handWhite.ico';
	}
	document.head.removeChild(oldLink);
	document.head.appendChild(link);
});
