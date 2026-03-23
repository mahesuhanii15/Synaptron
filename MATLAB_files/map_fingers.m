function fingers = map_fingers(gesture)

switch gesture
    case 0
        fingers = [0 0 0 0 0];
    case 1
        fingers = [1 1 1 1 1];
    case 2
        fingers = [0 0 0 0 0];
    case 3
        fingers = [1 1 0 0 0];
end

end