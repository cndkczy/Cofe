function [Awidth, Rowd] = RootWidthDensity(Rootimage, Length)
    % Width measurement
    % preallocate variables
    Awidth = nan(Length, 1);
    Rowd = nan(Length, 1);

    % identify the leftmost and rightmost non-zero pixels as a function of depth
    for i = 1:Length
        [~, col] = find(Rootimage(i, :) > 0);

        if ~isempty(col)
            Awidth(i) = max(col) - min(col);
            Rowd(i) = length(col) / (Awidth(i) + 1);
        end
    end
end
