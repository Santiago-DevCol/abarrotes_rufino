--Creando tablas
CREATE TABLE public.clientes
(
    autoid bigserial NOT NULL,
    nombres character varying(60) NOT NULL,
    apellidos character varying(60) NOT NULL,
    barrio character varying(30) NOT NULL,
    direccion character varying(30) NOT NULL,
    email character varying(50),
    telefono character varying(20) NOT NULL,
    codigo_postal character varying(15),
    PRIMARY KEY (autoid)
);

ALTER TABLE IF EXISTS public.clientes
    OWNER to postgres;
	


CREATE TABLE IF NOT EXISTS public."Factura_detalle"
(
    id_detalle bigint NOT NULL DEFAULT nextval('"Factura_detalle_id_detalle_seq"'::regclass),
    id_registro_detalle bigint NOT NULL,
    fk_autoid_cliente bigint NOT NULL DEFAULT nextval('"Factura_detalle_fk_autoid_cliente_seq"'::regclass),
    fk_sku_producto integer NOT NULL,
    fk_nombre_producto character varying(50) COLLATE pg_catalog."default" NOT NULL,
    fk_valor_unitario integer NOT NULL,
    cantidad_compra integer NOT NULL,
    CONSTRAINT "Factura_detalle_pkey" PRIMARY KEY (id_detalle),
    CONSTRAINT fk_autoid_cliente FOREIGN KEY (fk_autoid_cliente)
        REFERENCES public.clientes (autoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Factura_detalle"
    OWNER to postgres;
	

CREATE TABLE public.registro_compra_detalle_cliente
(
    id_registro_fac_cliente bigserial NOT NULL,
    fk_autoid_cliente bigserial NOT NULL,
    fk_idregistro_detalle bigint NOT NULL,
    total_venta integer NOT NULL,
    CONSTRAINT fk_autoid_cliente FOREIGN KEY (fk_autoid_cliente)
        REFERENCES public.clientes (autoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.registro_compra_detalle_cliente
    OWNER to postgres;
ALTER TABLE IF EXISTS public.registro_compra_detalle_cliente
    ADD CONSTRAINT fk_id_detalle FOREIGN KEY (fk_idregistro_detalle)
    REFERENCES public."Factura_detalle" (id_detalle) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
	


CREATE TABLE IF NOT EXISTS public.productos
(
    sku bigint NOT NULL,
    nombre_producto character varying(50) COLLATE pg_catalog."default" NOT NULL,
    descripcion text COLLATE pg_catalog."default",
    cantidad_stoke integer NOT NULL,
    precio integer NOT NULL,
    CONSTRAINT productos_pkey PRIMARY KEY (sku)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.productos
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.productos_por_detalle
(
    id_producto_detalle bigint NOT NULL DEFAULT nextval('productos_por_detalle_id_producto_detalle_seq'::regclass),
    fk_sku bigint NOT NULL,
    fk_idetalle bigint NOT NULL,
    CONSTRAINT productos_por_detalle_pkey PRIMARY KEY (id_producto_detalle),
    CONSTRAINT fk_idetalle FOREIGN KEY (fk_idetalle)
        REFERENCES public."Factura_detalle" (id_detalle) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sku FOREIGN KEY (fk_sku)
        REFERENCES public.productos (sku) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.productos_por_detalle
    OWNER to postgres;

