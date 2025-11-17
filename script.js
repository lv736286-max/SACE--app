document.addEventListener('DOMContentLoaded', ()=>{
  const screen = document.querySelector('.screen');
  screen.classList.add('fade-in');

  const btn = document.getElementById('welcomeBtn');
  btn.addEventListener('click', ()=>{
    btn.disabled = true;
    btn.textContent = 'Cargando...';
    btn.style.transform = 'scale(.98)';
    setTimeout(()=>{
      btn.textContent = '¡Listo!';
      btn.style.transform = '';
      btn.disabled = false;
    }, 900);
  });
});
