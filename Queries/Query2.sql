SELECT consignmentId, itemNumber, jewelleryType, description, DaysWaited, ownerName, clientName, businessIndicator, email, contactConsent
FROM owner f
JOIN
	(SELECT clientName, businessIndicator, ownerId, email, contactConsent, c.*
	FROM client d
	JOIN
		(SELECT a.consignmentId, clientId, itemNumber, jewelleryType, description, DATEDIFF(CURDATE(), dateRecieved) AS 'DaysWaited'
		FROM consignmentitem a
		JOIN consignment b
		ON a.consignmentId = b.consignmentId
        AND valuationId IS NULL) c
	ON c.clientId = d.clientId) e
ON e.ownerId = f.ownerId
ORDER BY DaysWaited DESC
; 