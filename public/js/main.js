
$('.cell').click(function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
  if (data.game_over === true && data.total_moves === 9){
      $('#message').text("Neither side is victorious. Maker, help us.");
      $('.cell').off();
    } 
    else if (data.game_over === true && data.total_moves < 9){
      $('#message').text("Your side is victorious. The fate of Ferelden lies with you.");
      $('.cell').off();
    }
    else {
      $('#message').text("Make your move, " + data.current_player + ".");
    }
  })
});


$('.cell').one('click', function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
    if (data.piece === 'M') {
      $(selectedCell).addClass('mage');
    }
    else if (data.piece === 'T') {
      $(selectedCell).addClass('templar');
    }
    console.log(data);
  })
});
