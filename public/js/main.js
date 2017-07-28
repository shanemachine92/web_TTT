
$('#newGame').click(function(){
  $('td').removeClass()
});

$('.cell').one('click', function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
    console.log(data)
    if (data.piece === 'M') {
      $(selectedCell).addClass('mage');
    }
    else if (data.piece === 'T') {
      $(selectedCell).addClass('templar');
    }
    $('#message').text("Make your move, " + data.current_player + ".");
  })
});

$('.cell').click(function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
     if (data.game_over === true && data.total_moves === 9){
      $('#message').text("Neither side is victorious. Maker, help us.");
    } 
    else if (data.game_over === true && data.total_moves != 9){
      $('#message').text("Your side is victorious. The fate of Ferelden lies with you.");
    }
  })
});
