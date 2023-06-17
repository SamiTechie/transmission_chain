import QtQuick

Canvas {
	width:600
	height:300
	id:canvas
	anchors.fill:parent
	property int rectangleWidth:100
	property int rectangleHeight:50
	onPaint: {
	function arrow(context, fromx,fromy,tox, toy){
		const dx = tox - fromx;
		const dy = toy - fromy
		const angle = Math.atan2(dy, dx)
		context.beginPath()
		context.moveTo(fromx, fromy)
		context.lineTo(tox, toy)
		context.stroke()
	}
	function line(context, fromx,fromy,tox, toy){
		context.beginPath()
		context.moveTo(fromx, fromy)
		context.lineTo(tox, toy)
		context.stroke()
	}
	function arcTo(context, centerx, centery,radius,startAngle,endAngle){
		context.beginPath()
		contex.moveTo(centerx,centery)
		context.arc(centerx,centery,10,Math.PI * 0.5,false)
		context.lineTo(centerx,centery)
		context.fill()
	}
	function rectangle(context,text,fromx,fromy,width,height){
		context.rect(fromx, fromy, width, height)
		const cx = width/2 + fromx
		context.textAlign = "center"
		const cy = height/2 + fromy
		context.fillText(text,cx,cy,width)
		context.stroke()
	}
	var ctx = getContext('2d')
	ctx.lineWidth = 1.5
	ctx.strokeStyle = 'black'
	// parm context,text,x,y,width,height
	rectangle(ctx,"Code en Ligne",0,0,rectangleWidth,rectangleHeight)
	arrow(ctx,rectangleWidth,rectangleHeight/2,2*rectangleWidth,rectangleHeight/2)
	rectangle(ctx,"Filtre\nd'emission",2*rectangleWidth,0,rectangleWidth,rectangleHeight)
	arrow(ctx,3*rectangleWidth,rectangleHeight/2,4*rectangleWidth,rectangleHeight/2)
	rectangle(ctx,"Modulation",4*rectangleWidth,0,rectangleWidth,rectangleHeight)
	line(ctx,5*rectangleWidth - rectangleWidth / 2,rectangleHeight,5*rectangleWidth - rectangleWidth / 2,rectangleWidth)
	line(ctx,5*rectangleWidth - rectangleWidth / 2,2*rectangleHeight,3*rectangleWidth - rectangleWidth / 2,2*rectangleHeight)
	line(ctx,3*rectangleWidth - rectangleWidth / 2,2*rectangleHeight,3*rectangleWidth - rectangleWidth / 2,3*rectangleHeight)
	rectangle(context, "Canal de Propagation",3*rectangleWidth - 2*rectangleWidth / 2,3*rectangleHeight,rectangleWidth,rectangleHeight)
	line(ctx,3*rectangleWidth - rectangleWidth / 2,4*rectangleHeight,3*rectangleWidth - rectangleWidth / 2,5*rectangleHeight)
	line(ctx,3*rectangleWidth - rectangleWidth / 2,5*rectangleHeight,5*rectangleWidth,5*rectangleHeight)
	line(ctx,5*rectangleWidth,5*rectangleHeight,5*rectangleWidth,6*rectangleHeight)
	line(ctx,5*rectangleWidth,6*rectangleHeight,4*rectangleWidth,6*rectangleHeight)

	}
}
