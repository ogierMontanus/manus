window.addEventListener('window-opened',
e => {
	const facs = e.detail.content.querySelector('pb-facsimile');

	setTimeout(() => {
		if(!facs.viewer) facs._initOpenSeadragon()
	} , 4)
});
