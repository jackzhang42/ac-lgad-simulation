(sde:clear)

(sdeio:read-tdr-bnd "n@node|-1@_bnd.tdr")

# (sdegeo:rotate-selected (get-body-list) (transform:rotation (position 0 0 0) (gvector 0 1 0) 90) #t)

(sdeio:save-tdr-bnd (get-body-list) "n@node@_bnd.tdr")
