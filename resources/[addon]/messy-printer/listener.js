
$(function(){
	window.onload = (e) => {
		
		const overlay = document.getElementById('overlay');
		const image = document.getElementById('image');

		var img = new Image();
		theimage = "";
		quantity = 1;
		//displayimage = false;
		
		img.onload = function() {
			//displayimage = true;
			$.post("https://messy-printer/imgresult", JSON.stringify({result:true,image:theimage,q:quantity}));
		};
		  
		img.onerror = function() {
			//displayimage = false;
			$.post("https://messy-printer/imgresult", JSON.stringify({result:false,image:theimage,q:quantity}));
		};

		function showImage(url) {
		  image.src = url;
		      
			  overlay.style.display = 'flex';

		
		overlay.addEventListener('click', hideImage);
			document.addEventListener('keydown', hideImageOnEscape);
		}

		
		function hideImage() {
		
		overlay.style.display = 'none';
		$.post("https://messy-printer/NUIFocusOff", JSON.stringify({}));
		
		overlay.removeEventListener('click', hideImage);
			document.removeEventListener('keydown', hideImageOnEscape);
		}

		
		function hideImageOnEscape(event) {
			if (event.key === 'Escape') {
			hideImage();
			}
		}
        
		window.addEventListener('message', (event) => {
            
			var item = event.data;
			if (item !== undefined && item.type === "open") {				
                showImage(item.theurl)
			}
			if (item !== undefined && item.type === "check") {
				theimage = item.theurl;
				quantity = item.quantity;
				img.src = theimage;
			}
			
		});
	};
});