function onSongStart()
    noteTweenX('Ayko-note0', 0, -500, 0.1, circInOut)
    noteTweenX('Ayko-note1', 1, -500, 0.1, circInOut)
    noteTweenX('Ayko-note2', 2, -500, 0.1, circInOut)
    noteTweenX('Ayko-note3', 3, -500, 0.1, circInOut)
end

function onUpdate(elapsed) 
    if curStep == 768  then
        doTweenZoom('camZOOM', 'camGame', 1.5, 1.1, 'linear')
    end
end