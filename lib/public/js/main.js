
$("#newGame").click(function(){
	$("td").removeClass()});

$('.cell').click(function(event){
	var selectedCell = event.target
	$.post('/do_turn', { cell: selectedCell.id }).done(function(data){
		console.log(data)
		if (data === 'M') {
			$(selectedCell).addClass('mage')
		}
		else {
			$(selectedCell).addClass('templar')
		}
	})
});


// #which cell
// #who clicked it
