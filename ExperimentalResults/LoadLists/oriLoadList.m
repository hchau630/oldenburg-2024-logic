function [loadList] = oriLoadList(listType)

% Smaller load list to test the code
if strcmp(listType,'short')
    loadList = {'210428_w32_2_outfile.mat'
    '210903_I151_3_outfile.mat'
    '210826_i151_3_outfile.mat'
    '210914_i151_3_outfile.mat'
    '210927_I154_2_outfile.mat'
    '211019_I156_1_outfile.mat'
    };
elseif strcmp(listType,'used')
    
    loadList = {'191126_I138_1_outfile.mat'
        '191206_I138_1_outfile.mat'
        '200302_W14_1_outfile.mat'
        '200311_i139_2_outfile.mat'
        '200723_i140_2_outfile.mat'
        '200729_I140_2_outfile.mat'
        '200902_w18_3_outfile.mat'
        '200901_w19_1_outfile.mat'
        '201202_w29_3_outfile.mat'
        '210903_I151_3_outfile.mat'
        '210826_i151_3_outfile.mat'
        '210914_i151_3_outfile.mat'
        '210927_I154_2_outfile.mat'
        '211021_W40_2_outfile.mat'
        '211019_I156_1_outfile.mat'
        '211102_I158_1_outfile.mat'
        '211108_I156_1_outfile.mat'
        '211019_I154_1_outfile.mat'
        };
        
else
    error('Unknown loadList. Options are ''short'' or ''long'' ')
end

