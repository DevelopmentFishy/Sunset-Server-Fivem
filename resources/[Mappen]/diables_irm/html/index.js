    var audioPlayer2 = document.getElementById('audioPlayer2');

    function playSound2(soundFile, volume) {
        audioPlayer2.src = soundFile;
        audioPlayer2.volume = volume;
        audioPlayer2.load();
        audioPlayer2.play();
    }

    function stopSound2() {
        audioPlayer2.pause();
    }

    audioPlayer2.addEventListener('ended', function() {
        // Relancer la musique lorsque celle-ci se termine
        var soundFile = audioPlayer2.src;
        var volume = audioPlayer2.volume;
        playSound2(soundFile, volume);
    });

    window.addEventListener('message', function(event) {
        if (event.data.transactionType === 'playUrl') {
            var soundFile = event.data.transactionFile;
            var volume = event.data.volume;
            playSound2(soundFile, volume);
        } else if (event.data.transactionType === 'stop') {
            stopSound2();
        } else if (event.data.transactionType === 'volume') {
            var volume = event.data.volume;
            audioPlayer2.volume = volume;
        }
    });
	
// On commence par cacher le menu
const menuui = document.getElementById('menuui');
menuui.style.display = 'none';

// On crée une fonction pour afficher ou cacher le menu
function toggleMenuIRM() {
  if (menuui.style.display === 'none') {
    menuui.style.display = 'block';
    selectedIndex = 1;
    moveSelection('up', menuItems);
  } else {
    menuui.style.display = 'none';
  }
}

// écouter les messages NUI
window.addEventListener('message', function(event) {
  // vérifier si le type de message est "toggleMenuIRM"
  if (event.data.type === 'toggleMenuIRM') {
    toggleMenuIRM();
  }
});

let selectedIndex = 0; 
const menuItems = document.querySelectorAll('.menu-item');

// Ajouter un écouteur d'événements pour détecter les touches de clavier pressées
document.addEventListener('keydown', function(event) {
  if (menu.style.display === 'block') {
  const menuItems = document.querySelectorAll('#menu .menu-item');
  const menu = document.getElementById('menu');

  switch(event.key) {
    case 'Backspace':
      menuui.style.display = 'none';
      closePanelIRM();
      break;
    case 'ArrowUp':
      moveSelection('up', menuItems);
      break;
    case 'ArrowDown':
      moveSelection('down', menuItems);
      break;
    case 'Enter':
      const selectedItem = menuItems[selectedIndex];
      const itemType = selectedItem.dataset.type;

      switch(selectedIndex) {
        case 0:
          ONRADIO();
          break;
        case 1:
          OFFRADIO();
          break;
        default:
          break;
      }

      break;
    default:
      break;
    }
  }
});

function moveSelection(direction, menuItems) {
  const element = document.getElementById('menu');
  const menuHeight = element.clientHeight;

  menuItems[selectedIndex].classList.remove('selected');

  if (direction === 'up') {
    selectedIndex = (selectedIndex === 0) ? menuItems.length - 1 : selectedIndex - 1;

    // Faire défiler la liste vers le haut
    const itemHeight = menuItems[0].clientHeight; // Taille d'un élément de la liste
    const scrollDistance = selectedIndex * itemHeight - menuHeight + itemHeight;
    element.scrollTop = Math.max(scrollDistance, 0);
  } else if (direction === 'down') {
    selectedIndex = (selectedIndex === menuItems.length - 1) ? 0 : selectedIndex + 1;

    // Faire défiler la liste vers le bas
    const itemHeight = menuItems[0].clientHeight; // Taille d'un élément de la liste
    const scrollDistance = (selectedIndex + 1) * itemHeight - menuHeight;
    element.scrollTop = Math.min(scrollDistance, element.scrollHeight - menuHeight);
  }

  menuItems[selectedIndex].classList.add('selected');
  // console.log("selectedIndex dans le menu:", selectedIndex);
}

// Envoyer un message pour fermer le menu
function closePanelIRM() {
  $.post(`https://${GetParentResourceName()}/menuClosedIRM`, JSON.stringify({}), function() {
  });
}

function ONRADIO() {
  $.post(`https://${GetParentResourceName()}/StartIRM`, JSON.stringify({}), function() {
    // Callback function (si nécessaire)
  });
}
function OFFRADIO() {
  $.post(`https://${GetParentResourceName()}/StopIRM`, JSON.stringify({}), function() {
    // Callback function (si nécessaire)
  });
}