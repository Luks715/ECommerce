document.addEventListener('DOMContentLoaded', function() {
    var btn_produtos_index = document.getElementById('btn_produtos_index');
    var btn_categoria_index = document.getElementById('btn_categoria_index');
    var btn_vendedores_index = document.getElementById('btn_vendedores_index');
  
    var produtos_content   = document.getElementById('produtos_content');
    var categorium_content = document.getElementById('categorium_content');
    var vendedores_content = document.getElementById('vendedores_content');
  
    btn_produtos_index.addEventListener('click', function() {
      hideAllContents();
      produtos_content.style.display = 'block';
    });

    btn_categoria_index.addEventListener('click', function(){
      hideAllContents();
      categorium_content.style.display = 'block';
    });
  
    btn_vendedores_index.addEventListener('click', function() {
      hideAllContents();
      vendedores_content.style.display = 'block';
    });
  
    function hideAllContents() {
      produtos_content.style.display = 'none';
      categorium_content.style.display = 'none';
      vendedores_content.style.display = 'none';
    }
  });
  