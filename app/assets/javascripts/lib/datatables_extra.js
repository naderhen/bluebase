$.fn.dataTableExt.oApi.fnGetFilteredNodes = function ( oSettings )
{
    var anRows = [];
    for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
    {
        var nRow = oSettings.aoData[ oSettings.aiDisplay[i] ].nTr;
        anRows.push( nRow );
    }
    return anRows;
};

$.fn.dataTableExt.oApi.fnGetFilteredData = function ( oSettings ) {
    var a = [];
    for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ ) {
        a.push(oSettings.aoData[ oSettings.aiDisplay[i] ]._aData);
    }
    return a;
}

$.fn.dataTableExt.afnFiltering.push(
	function( oSettings, aData, iDataIndex ) {
		var table = $(oSettings.nTable);
		if (oSettings.sTableId == "inventory-table") {
			var conditions = [];
			if (table.hasClass('filter-weight')) {
				var weightRange = $("#weight-range").data('slider'),
					min = weightRange.options.values[0],
					max = weightRange.options.values[1],
					row_weight = aData[4];

				conditions.push(row_weight > min && row_weight < max);
			}

			if (table.hasClass('filter-age')) {
				var ageRange = $("#age-range").data('slider'),
					min = ageRange.options.values[0],
					max = ageRange.options.values[1],
					row_age = parseInt(aData[10]);

				conditions.push(row_age > min && row_age < max);
			}

			if (table.hasClass('core-grade-filter')) {
				var checkedArray = _.pluck($('.core-grade-filter:checked'), 'value'),
					row_grade = aData[6];

				if (row_grade == "") {
					conditions.push(true)
				} else {
					if (checkedArray.length > 0 && _.indexOf(checkedArray, "All") == -1) {
						conditions.push(_.indexOf(checkedArray, row_grade) > -1);
					} else {
						conditions.push(true);
					}
				}
			};

			if (table.hasClass('freshness-grade-filter')) {
				var checkedArray = _.pluck($('.freshness-grade-filter:checked'), 'value'),
					row_grade = aData[7];

				if (row_grade == "") {
					conditions.push(true)
				} else {
					if (checkedArray.length > 0 && _.indexOf(checkedArray, "All") == -1) {
						conditions.push(_.indexOf(checkedArray, row_grade) > -1);
					} else {
						conditions.push(true);
					}
				}
			};

			if (table.hasClass('texture-grade-filter')) {
				var checkedArray = _.pluck($('.texture-grade-filter:checked'), 'value'),
					row_grade = aData[8];

				if (row_grade == "") {
					conditions.push(true)
				} else {
					if (checkedArray.length > 0 && _.indexOf(checkedArray, "All") == -1) {
						conditions.push(_.indexOf(checkedArray, row_grade) > -1);
					} else {
						conditions.push(true);
					}
				}
			};

			if (table.hasClass('tail-grade-filter')) {
				var checkedArray = _.pluck($('.tail-grade-filter:checked'), 'value'),
					row_grade = aData[9];

				if (row_grade == "") {
					conditions.push(true)
				} else {
					if (checkedArray.length > 0 && _.indexOf(checkedArray, "All") == -1) {
						conditions.push(_.indexOf(checkedArray, row_grade) > -1);
					} else {
						conditions.push(true);
					}
				}
			};

			return _.all(conditions, _.identity);
		} else {
			return true;
		}
	}
);