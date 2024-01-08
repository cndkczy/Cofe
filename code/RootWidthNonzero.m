function [Awidth, Rownonzero] = RootWidthNonzero(Rootimage, Length)
    % Measures width
    % preallocate variables
    Awidth = nan(Length, 1);
    Rownonzero = nan(Length, 1);

    % identify the leftmost and rightmost non-zero pixels as a function of depth
    for i = 1:Length
        [~, col] = find(Rootimage(i, :) > 0);

        if ~isempty(col)
            Awidth(i) = max(col) - min(col);
            Rownonzero(i) = length(col);
        end
    end
end
