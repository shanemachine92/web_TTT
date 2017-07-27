
$("#newGame").click(function(){
  $("td").removeClass()
});

$('.cell').click(function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
    if (data.piece === 'M') {
      $(selectedCell).addClass('mage')
    }
    else {
      $(selectedCell).addClass('templar')
    }
  })
});

$('.cell').click(function(event){
  var selectedCell = event.target
  $.post('/set_cell', { cell: selectedCell.id }).done(function(data){
     if (data.game_over === true && data.total_moves === 9){
      $('#message').text("Neither side is victorious. Maker, help us.")
    } 
    else if (data.game_over === true && data.total_moves != 9){
      $('#message').text("Your side is victorious. The fate of Ferelden lies with you.")
    }
    else {
       $('#message').text("Make your move, " + data.current_player + ".")
    }
  })
})
