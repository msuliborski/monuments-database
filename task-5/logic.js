var player = document.getElementById("player");
var playerW = parseInt(player.attributes.r.value*2);
var playerH = parseInt(player.attributes.r.value*2);
var playerR = parseInt(player.attributes.r.value);

var scoreText = document.getElementById("score-text");
var playText = document.getElementById("play-text");

var ballNumber = 0;
var ballSpeed = 5;
var score = 0;
var playerSpeed = 0;
var playerSpeedCoefficient = 5;

var spawning;
var lowering;
var colliding;
var steering;

isLeftArrowPressed = false;
isRightArrowPressed = false;
isSpacePressed = false;

function startGame() {
    spawning = setInterval(spawnBall, 1000);
    lowering = setInterval(lowerBalls, 16.67);
    colliding = setInterval(checkCollcions, 16.67);
    steering = setInterval(handlePlayer, 16.67);

    ballNumber = 0;
    score = 0;
    scoreText.innerHTML = score;

    playText.setAttribute("visibility", "hidden")
}


function spawnBall() {
    var newBall = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    newBall.setAttributeNS(null,"id","ball"+ballNumber);
    newBall.setAttributeNS(null,"cx",randomNumber(25, 375));
    newBall.setAttributeNS(null,"cy",-25);
    newBall.setAttributeNS(null,"r",25);
    r = Math.floor(randomNumber(1, 3));
    var color = "red";
    if(r == 1) color = "red";
    else if(r == 2) color = "blue";
    else if(r == 3) color = "green";
    newBall.setAttributeNS(null,"fill", color+"");
    newBall.setAttributeNS(null,"stroke","none");

    document.getElementById("svg").appendChild(newBall);
    ballNumber++;
}

function lowerBalls() {
    var i;
    for (i = 0; i < ballNumber; i++) {
        ball = document.getElementById("ball"+i);
        if (ball != null) {
            ball.setAttribute('cy', (ball.attributes.cy.value*1 + ballSpeed*1));
            if (ball.attributes.cy.value * 1 >= 825) {
                endGame();
            }
        }
    }
}

function checkCollcions() {
    var i;
    for (i = 0; i < ballNumber; i++) {
        ball = document.getElementById("ball"+i);
        if (ball != null) {
            if (Math.sqrt((player.attributes.cx.value*1 - ball.attributes.cx.value*1)*(player.attributes.cx.value*1 - ball.attributes.cx.value*1) +
                (player.attributes.cy.value*1 - ball.attributes.cy.value*1)*(player.attributes.cy.value*1 - ball.attributes.cy.value*1)) <= 50) {
                if (player.attributes.fill.value+"" == ball.attributes.fill.value+"") {
                    ball.remove();
                    score++;
                    scoreText.innerHTML = score;
                } else {
                    endGame();
                }
            }
        }
    }
    if (score <= 9) scoreText.setAttribute("x", 160);
    else scoreText.setAttribute("x", 120);
}

function handlePlayer() {
    document.onkeydown = function(e){
        switch(e.keyCode){
            case 32: isSpacePressed = true; break;
            case 37: isLeftArrowPressed = true; break;
            case 39: isRightArrowPressed = true; break;
        }
    };

    document.onkeyup = function(e){
        switch(e.keyCode){
            case 32: isSpacePressed = false; break;
            case 37: isLeftArrowPressed = false; break;
            case 39: isRightArrowPressed = false; break;
        }
    };

    if (isSpacePressed){
        isSpacePressed = false;
        if (player.attributes.fill.value == "red") player.setAttribute("fill", "green")
        else if (player.attributes.fill.value == "green") player.setAttribute("fill", "blue")
        else if (player.attributes.fill.value == "blue") player.setAttribute("fill", "red")
    }

    if (isLeftArrowPressed) playerSpeed = -playerSpeedCoefficient;
    if (isRightArrowPressed) playerSpeed = playerSpeedCoefficient;
    if (isRightArrowPressed && isLeftArrowPressed || (!isRightArrowPressed && !isLeftArrowPressed)) playerSpeed = 0;
    player.setAttribute('cx', player.attributes.cx.value*1 + playerSpeed);
    if (player.attributes.cx.value*1 - playerW/2 <= 0) player.setAttribute('cx', playerW/2);
    if (player.attributes.cx.value*1 + playerW/2 >= 450) player.setAttribute('cx', 450 - playerW/2);
}



function endGame() {
    clearInterval(spawning);
    clearInterval(lowering);
    clearInterval(colliding);
    clearInterval(steering);

    var i;
    for (i = 0; i < ballNumber; i++) {
        ball = document.getElementById("ball"+i);
        if (ball != null) ball.remove();
    }

    playText.setAttribute("visibility", "visible")
}


function randomNumber(min, max){
    return Math.random() * (max - min) + min;
}

