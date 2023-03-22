SELECT h.consignmentId, itemNumber, h.clientId, clientName, ownerName, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
FROM owner i
JOIN
	(SELECT g.consignmentId, g.clientId, clientName, ownerId, itemNumber, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
	FROM client f
	JOIN
		(SELECT e.consignmentId, clientId, itemNumber, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
		FROM consignment e
		JOIN
			(SELECT *
			FROM consignmentitem a
			JOIN keyword b
			ON a.description LIKE CONCAT ('%', b.keyword, '%')
			AND b.keyword = 'diamond') c
		ON e.consignmentId = c.consignmentId
		AND valuationId IS NULL) g
	ON f.clientId = g.clientId) h
ON i.ownerId = h.ownerId
ORDER BY h.consignmentId, h.itemNumber
;