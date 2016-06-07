function vRecoveredMessage = expParaCRTInvReconstruct(cReconMessage_bigd, vModului_bigd, numData)


reconFactor = length(vModului_bigd);
vTempRecoveredMessage = zeros(reconFactor, length(cReconMessage_bigd));

parfor idx = 1:length(cReconMessage_bigd)
	cDecryptedMessage_i_bigd = cReconMessage_bigd{idx};
	vRecoveredMessage_part = zeros(reconFactor, 1);
	for jdx = 1:reconFactor
		vRecoveredMessage_part(jdx) = bigd2dbl(cDecryptedMessage_i_bigd.remainder(vModului_bigd(jdx)));
	end

	vTempRecoveredMessage(:, idx) = vRecoveredMessage_part;
end

vTempRecoveredMessage = vTempRecoveredMessage(1:numData);
vRecoveredMessage = reshape(vTempRecoveredMessage, numData, 1);

end