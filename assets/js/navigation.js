'use strict';
const menuToggle = document.querySelector('.academic-menu-toggle');
const menu = document.querySelector('#academic-navigation');
const narrowHeader = window.matchMedia('(max-width: 924px)');
function resetMenu() {
  menuToggle.hidden = !narrowHeader.matches;
  menuToggle.setAttribute('aria-expanded', 'false');
  menu.hidden = narrowHeader.matches;
}
menuToggle.addEventListener('click', () => {
  const expanded = menuToggle.getAttribute('aria-expanded') === 'true';
  menuToggle.setAttribute('aria-expanded', String(!expanded));
  menu.hidden = expanded;
});
document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape' && menuToggle.getAttribute('aria-expanded') === 'true') {
    resetMenu();
    menuToggle.focus();
  }
});
narrowHeader.addEventListener('change', resetMenu);
resetMenu();
